import { createSlice } from '@reduxjs/toolkit';

interface NavbarState {
  items: any;
  error: string | null;
}

const initialState: NavbarState = {
  items: [],
  error: '',
};

const navbarSlice = createSlice({
  name: 'navbar',
  initialState,
  reducers: {
    addNavbarData: (state, action) => {
      state.items = action?.payload;
      state.error = '';
    },
  },
});

export const { addNavbarData } = navbarSlice.actions;

export default navbarSlice.reducer;
